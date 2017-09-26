From: Pako Fonseca <ratjar501@gmail.com>
Date: Tue, 26 Sep 2017 17:57:13 -0500
Subject: [LTP] Issue running cpuset_base_ops_testset shell script
Message-ID: <CALhEcWHtmEd+VHOOSHCzpLppCRVAe8pUYrJD1+aGim=4oA2T7g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

**LTP Version: 20160920
Kernel Version: 3.10.0-327.el7.x86_64
OS: CentOS Linux release 7.2.1511 (Core)**

Good day, i'm trying to run this test script
"**cpuset_base_ops_testset.sh**" but when i do that i have multiple
errors related to some missing devices under **/dev/cpuset/** here is
the output:
```
opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
/dev/cpuset/cpus: Permission denied
cat: /dev/cpuset/cpus: No such file or directory

opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
/dev/cpuset/mems: Permission denied
cat: /dev/cpuset/mems: No such file or directory

opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
/dev/cpuset/memory_pressure: Permission denied
cat: /dev/cpuset/memory_pressure: No such file or directory
```
I only posted a few errors but are many of them with the same message
"Permission denied"
Note: I already tried to run it with runltp tool but I have the same errors

I tried changing the script execution permission and also running it
as root but doesn't change anything do you know what could be wrong?
