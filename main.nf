#!/usr/bin/env nextflow 
params.exit = 0

process foo {
  machineType 'bar'
  maxForks 1

  input:
  val x

  script:
  """
  echo "Sleeping for $x seconds"
  sleep $x
  exit $params.exit
  """
}

workflow {
  def sleepTimes = [60, 60, 120, 120, 240, 240]
  channel.of(*sleepTimes) | foo
}
