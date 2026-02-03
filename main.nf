#!/usr/bin/env nextflow 
params.greeting = "Hello"
params.timeout = 10
params.exit = 0
params.cmd = "echo '$params.greeting (sleeping $params.timeout seconds)'"
params.times = 1 

process foo {
  maxForks 1 
  input: val(x)
  /
  bash -c "$params.cmd"
  sleep $params.timeout
  exit $params.exit
  /
}

workflow {
  channel.of(1..params.times) | foo
}
