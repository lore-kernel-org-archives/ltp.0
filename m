From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 03 Nov 2015 17:03:05 +0300
Subject: [LTP] How about set IPsec with ip xfrm?
In-Reply-To: <CAPwn2JS9pB39amE4azR9OP8W18SCC8X=8brxdRLv5swEr5kCLg@mail.gmail.com>
References: <CAPwn2JRO0Dx20LzBHrLhMb85EoU9+_WRnRTS5UO2sQ9Ej3y+Cw@mail.gmail.com>	<562F7947.30501@oracle.com>
 <CAPwn2JS9pB39amE4azR9OP8W18SCC8X=8brxdRLv5swEr5kCLg@mail.gmail.com>
Message-ID: <5638BE99.4010600@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Hangbin,

OK, I've reviewed the icmp tests draft, here are the comments:

* I wouldn't add tst_ipsec() to test_net.sh because this function will 
only be run in IPsec related tests, the rest network tests will include 
it with no good reason. We can move all ipsec related tests to one 
directory under network/stress/ipsec and create common library script there.

* c2x() function can be added to test.sh because it is more or less 
generic, but it should be fixed to print the message in LTP style format.

* Make sure you don't run LTP_RSH directly.

* Don't use absolute path to run commands, it can differ from one 
environment to another. They should be in the PATH before the tests 
start. You can verify that particular command is available with 
tst_check_cmds() in the test script.

* icmp_check_connectivity (ping) can be merged to test_net.sh, other 
network test could run it too.

Thanks,
Alexey

