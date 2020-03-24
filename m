From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 24 Mar 2020 07:59:30 +0000
Subject: [LTP] tar01_sh testcase failure
In-Reply-To: <MAXPR0101MB1468556AA605AAB483768D00EEF00@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB1468556AA605AAB483768D00EEF00@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <MAXPR0101MB146889BD817A82D85D729C27EEF10@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,
i am trying to run tar01_sh on RISC v with custom yocto distro i am getting following errors can  you help me to reach out to problem.

cmdline="tar_tests.sh"
contacts=""
analysis=exit
<<<test_output>>>
tar_tests 1 TINFO: timeout per run is 0h 5m 0s
a file1
a file2
a file3
tar_tests 1 TPASS: tar cvf test.tar file1 file2 file3 > tar.out passed as expected
tar_tests 1 TFAIL: Unexpected number of lines in tar.out
Usage:
  List:    tar -tf <archive-filename>
  Extract: tar -xf <archive-filename>
  Create:  tar -cf <archive-filename> [filenames...]
  Help:    tar --help
tar_tests 1 TFAIL: tar dvf test.tar > tar.out failed unexpectedly
tar_tests 1 TFAIL: Unexpected number of lines in tar.out
tar_tests 1 TPASS: tar tvf test.tar > tar.out passed as expected
tar_tests 1 TPASS: Listing in tar.out is correct
x file1
x file2
x file3
tar_tests 1 TPASS: tar xvf test.tar > tar.out passed as expected
tar_tests 1 TFAIL: Unexpected number of lines in tar.out
tar_tests 1 TPASS: Files were uncompressed correctly
a file4
tar_tests 1 TPASS: tar rvf test.tar file4 > tar.out passed as expected
tar_tests 1 TFAIL: Unexpected number of lines in tar.out
tar_tests 1 TPASS: tar tvf test.tar > tar.out passed as expected
tar_tests 1 TPASS: Listing in tar.out is correct
x file1
x file2
x file3
x file4
tar_tests 1 TPASS: tar xvf test.tar > tar.out passed as expected
tar_tests 1 TFAIL: Unexpected number of lines in tar.out
tar_tests 1 TPASS: Files were uncompressed correctly
a file1
a file2
a file3
tar_tests 2 TPASS: tar cvfz test.tar.gz file1 file2 file3 > tar.out passed as expected
tar_tests 2 TFAIL: Unexpected number of lines in tar.out
Usage:
  List:    tar -tf <archive-filename>
  Extract: tar -xf <archive-filename>
  Create:  tar -cf <archive-filename> [filenames...]
  Help:    tar --help
tar_tests 2 TFAIL: tar dvf test.tar.gz > tar.out failed unexpectedly
tar_tests 2 TFAIL: Unexpected number of lines in tar.out
tar_tests 2 TPASS: tar tvf test.tar.gz > tar.out passed as expected
tar_tests 2 TPASS: Listing in tar.out is correct
x file1
x file2
x file3
tar_tests 2 TPASS: tar xvf test.tar.gz > tar.out passed as expected
tar_tests 2 TFAIL: Unexpected number of lines in tar.out
tar_tests 2 TPASS: Files were uncompressed correctly
a file1
a file2
a file3
tar_tests 3 TPASS: tar cvfj test.tar.bz2 file1 file2 file3 > tar.out passed as expected
tar_tests 3 TFAIL: Unexpected number of lines in tar.out
Usage:
  List:    tar -tf <archive-filename>
  Extract: tar -xf <archive-filename>
  Create:  tar -cf <archive-filename> [filenames...]
  Help:    tar --help
tar_tests 3 TFAIL: tar dvf test.tar.bz2 > tar.out failed unexpectedly
tar_tests 3 TFAIL: Unexpected number of lines in tar.out
tar_tests 3 TPASS: tar tvf test.tar.bz2 > tar.out passed as expected
tar_tests 3 TPASS: Listing in tar.out is correct
x file1
x file2
x file3
tar_tests 3 TPASS: tar xvf test.tar.bz2 > tar.out passed as expected
tar_tests 3 TFAIL: Unexpected number of lines in tar.out
tar_tests 3 TPASS: Files were uncompressed correctly
tar_tests 4 TPASS: tar cf test.tar file1 file2 file3 > tar.out passed as expected
tar_tests 4 TPASS: Tar produced no output
Usage:
  List:    tar -tf <archive-filename>
  Extract: tar -xf <archive-filename>
  Create:  tar -cf <archive-filename> [filenames...]
  Help:    tar --help
tar_tests 4 TFAIL: tar df test.tar > tar.out failed unexpectedly
tar_tests 4 TPASS: Tar produced no output
tar_tests 4 TPASS: tar tf test.tar > tar.out passed as expected
tar_tests 4 TPASS: Listing in tar.out is correct
tar_tests 4 TPASS: tar xf test.tar > tar.out passed as expected
tar_tests 4 TPASS: Tar produced no output
tar_tests 4 TPASS: Files were uncompressed correctly
tar_tests 4 TPASS: tar rf test.tar file4 > tar.out passed as expected
tar_tests 4 TPASS: Tar produced no output
tar_tests 4 TPASS: tar tf test.tar > tar.out passed as expected
tar_tests 4 TPASS: Listing in tar.out is correct
tar_tests 4 TPASS: tar xf test.tar > tar.out passed as expected
tar_tests 4 TPASS: Tar produced no output
tar_tests 4 TPASS: Files were uncompressed correctly
tar_tests 5 TPASS: tar cfz test.tar.gz file1 file2 file3 > tar.out passed as expected
tar_tests 5 TPASS: Tar produced no output
Usage:
  List:    tar -tf <archive-filename>
  Extract: tar -xf <archive-filename>
  Create:  tar -cf <archive-filename> [filenames...]
  Help:    tar --help
tar_tests 5 TFAIL: tar df test.tar.gz > tar.out failed unexpectedly
tar_tests 5 TPASS: Tar produced no output
tar_tests 5 TPASS: tar tf test.tar.gz > tar.out passed as expected
tar_tests 5 TPASS: Listing in tar.out is correct
tar_tests 5 TPASS: tar xf test.tar.gz > tar.out passed as expected
tar_tests 5 TPASS: Tar produced no output
tar_tests 5 TPASS: Files were uncompressed correctly
tar_tests 6 TPASS: tar cfj test.tar.bz2 file1 file2 file3 > tar.out passed as expected
tar_tests 6 TPASS: Tar produced no output
Usage:
  List:    tar -tf <archive-filename>
  Extract: tar -xf <archive-filename>
  Create:  tar -cf <archive-filename> [filenames...]
  Help:    tar --help
tar_tests 6 TFAIL: tar df test.tar.bz2 > tar.out failed unexpectedly
tar_tests 6 TPASS: Tar produced no output
tar_tests 6 TPASS: tar tf test.tar.bz2 > tar.out passed as expected
tar_tests 6 TPASS: Listing in tar.out is correct
tar_tests 6 TPASS: tar xf test.tar.bz2 > tar.out passed as expected
tar_tests 6 TPASS: Tar produced no output
tar_tests 6 TPASS: Files were uncompressed correctly

Summary:
passed   51
failed   17
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=45 cstime=45
<<<test_end>>>

Thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200324/b11456fc/attachment-0001.htm>
