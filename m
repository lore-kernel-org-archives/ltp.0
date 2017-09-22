From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Sep 2017 08:28:46 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/access01: Set umask value before run case
In-Reply-To: <1505826277-33027-1-git-send-email-cuibixuan@huawei.com>
References: <1505826277-33027-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <875562.19773227.1506083326749.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The case will fail when set the umask to 0077 acquiescently in system.
> Because the value of actual mode is 'set value' & ~'default value
> for the umask' when create dir.
> So add 'umask(0022)' in setup().

We do umask(0) in ltp-pan:

# umask
0077

# /opt/ltp/runltp -p -d results -l RUNTEST.log -o RUNTEST.run.log -s access01 -f syscalls > /dev/null

# cat /opt/ltp/results/RUNTEST.log
Test Start Time: Fri Sep 22 14:24:28 2017
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
access01                       PASS       0    

I'm aware that running tests outside of ltp-pan is sometimes useful,
so maybe we could add this to a library rather than in each test
separately? What do you think Cyril?

Regards,
Jan
