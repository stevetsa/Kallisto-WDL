task quant {

  File CDNAindex
  File read1
  File read2

  command <<<
    mkdir temp
    chmod 777 temp
    echo "setup files are :"
    find `pwd`
    echo -ne "\n\n"
    kallisto quant -o temp -i ${CDNAindex} ${read1} ${read2}
    tar -zcvf quant.tar.gz temp    
    echo "ending files are :"
    find `pwd`

  >>>

  runtime {
    docker : "stevetsa/docker-kallisto:latest"
    memory: "4G"
    cpu: "8"
  }

  output {
    File TAR = "quant.tar.gz"
  }
}


workflow kallisto {
  File CDNAindex
  File read1
  File read2

  call quant {
    input:
      CDNAindex = CDNAindex,
      read1 = read1,
      read2 = read2
  }
}

