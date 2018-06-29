From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Jun 2018 17:41:28 +0200
Subject: [LTP] runltp fails with Buildroot
In-Reply-To: <CA+Kjy2xkPvL+MY=p9AVkmgaqY8LAJXXhYE1hgAF4jmZ4WfpgbQ@mail.gmail.com>
References: <CA+Kjy2zzPOUcUP7yYu-OcA4NrKhp+fNW9PNObfxiAuPWsUw0eg@mail.gmail.com>
 <20180625134200.GB24288@rei>
 <CA+Kjy2zehQeA8c1gfmj4jXDDdPwdTWkS41aH=B7guXnRDS8m4A@mail.gmail.com>
 <20180626160543.GA24350@rei.lan>
 <CA+Kjy2yAH7-VYoMsZ_XQOuhY3UK_HXzKxxwMdMedW+-wkirY5A@mail.gmail.com>
 <20180627083801.GB24350@rei.lan>
 <CA+Kjy2xkPvL+MY=p9AVkmgaqY8LAJXXhYE1hgAF4jmZ4WfpgbQ@mail.gmail.com>
Message-ID: <20180629154128.GA26080@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Tests which require a big block device are disabled.
> You can specify it with option -z
> COMMAND:    /usr/lib/ltp-testsuite/bin/ltp-pan   -e -S   -a 145     -n
> 145 -p -f /tmp/ltp-XXXX9KSUqp/alltests -l
> /usr/lib/ltp-testsuite/results/LTP_Rf
> LOG File: /usr/lib/ltp-testsuite/results/LTP_RUN_ON-1970_01_01-00h_14m_06s.log
> OUTPUT File: /usr/lib/ltp-testsuite/output/output.log
> FAILED COMMAND File: /usr/lib/ltp-testsuite/output/LTP_RUN_ON-output.log.failed
> TCONF COMMAND File: /usr/lib/ltp-testsuite/output/LTP_RUN_ON-output.log.tconf
> Running tests.......
> Segmentation fault
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20180118
> sh: !: unknown operand
> tar: removing leading '/' from member names
> Created TAR File: ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar
> successfully, added /usr/lib/ltp-testsuite/output
> tar: invalid option -- u
> BusyBox v1.27.2 (2018-05-03 22:47:13 IST) multi-call binary.
> 
> Usage: tar -[cxthvO] [-X FILE] [-T FILE] [-f TARFILE] [-C DIR] [FILE]...
> 
> Create, extract, or list files from a tar file
> 
> Operation:
>         c       Create
>         x       Extract
>         t       List
>         f       Name of TARFILE ('-' for stdin/out)
>         C       Change to DIR before operation
>         v       Verbose
>         O       Extract to stdout
>         h       Follow symlinks
>         exclude File to exclude
>         X       File with names to exclude
>         T       File with names to include
> Cannot Update TAR File: ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar

You version of tar is missing -u option, it's pretty much obvious from
the log.

> for adding /usr/lib/ltp-testsuite/results
> Gunzipped TAR File: ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar
> Starting mailing reports to: umeshyv@gmail.com, file:
> ./LTP_RUN_201801181970_01_01-00h_14m_06s.tar.gz
> ./runltp: line 1043: mail: not found
> Reports cannot be mailed to: umeshyv@gmail.com

This log does not seem to match the runltp script, there is no mail
command called in there and the line 1043 is the last line of the script
in our repository.

-- 
Cyril Hrubis
chrubis@suse.cz
