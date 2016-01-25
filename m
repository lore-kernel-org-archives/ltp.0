From: Raghavendra Kakarla <Raghavendra.Kakarla@inedasystems.com>
Date: Mon, 25 Jan 2016 08:02:41 +0000
Subject: [LTP] Some LTP testcases are getting failed
Message-ID: <MA1PR01MB00562DFACF1908498176882C82C70@MA1PR01MB0056.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

I built the LTP for the yocto and ran it on the My board which has the Mips interaptive CPU.

After running all tests 42 test are getting failed.

I have examine the each failed test case and noted down the issue.

Following test cases are failed:

1.bind02 - unable to open the socket to testuser
2.chmod06 - Device busy error.
3.getrusage03 - memory allocation failed
4.Readahead02 - Page cache on our system is too small to hold whole testfile.
5.rt_sigaction01 - Gives the buss error.

Could you please help me to resolving this issues.

Thanks in Advance.

Regards,
Raghavendra K.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160125/e3cab8e4/attachment.html>
