From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 18 Feb 2020 16:06:46 +0800
Subject: [LTP] cpuset_regression_test failure
In-Reply-To: <MAXPR0101MB1468A284450566343010E440EE110@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB1468A284450566343010E440EE110@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <fa9fae7c-2110-d710-7df8-c3885e54d706@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi
> Hi,
> I am trying to run *cpuset_regression_test* on my linux 5.4.3 with our 
> Yocto distro,i got *FAIL* result for this test when i ran complete ltp 
> test but i did not got reason for test failure but when i tried to run 
> this test seperately it showing is it correct way to run this test,how 
> this test needs to be ran independently?
sh can not be ran independently unless using runltp sh.
ltp has many runtest files, you can grep cpuset_regression_test.sh in 
ltp/runtest file.
such as "
# grep -nsr cpuset_regression_test.sh
controllers:353:cpuset_regression_test cpuset_regression_test.sh
(cpuset_regression_test is a tag, and cpuset_regression_test.sh is 
indeed excutable file)

Then you can specify -f to chose runtest file and -s to match string 
pattern by using runltp sh in /opt/ltp directory.(You can ./runltp 
--help see more info)

run this case independently as below:
cd /opt/ltp
./runltp -f controllers -s  cpuset_regression_test

Best Regards
Yang Xu
> 
> root@exaleapsemi:~/pankaj_ltp_new/ltp/testcases/kernel/controllers/cpuset# 
> *./cpuset_regression_test.sh *
> 
> .*/cpuset_regression_test.sh: line 27: .: test.sh: file not found*
> 
> 
> 
> 
> 


