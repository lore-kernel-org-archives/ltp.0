From: Bixuan Cui <cuibixuan@huawei.com>
Date: Mon, 25 Sep 2017 10:34:18 +0800
Subject: [LTP] [PATCH] syscalls/access01: Set umask value before run case
In-Reply-To: <875562.19773227.1506083326749.JavaMail.zimbra@redhat.com>
References: <1505826277-33027-1-git-send-email-cuibixuan@huawei.com>
 <875562.19773227.1506083326749.JavaMail.zimbra@redhat.com>
Message-ID: <59C86B2A.9010901@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/9/22 20:28, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> The case will fail when set the umask to 0077 acquiescently in system.
>> Because the value of actual mode is 'set value' & ~'default value
>> for the umask' when create dir.
>> So add 'umask(0022)' in setup().
> 
> We do umask(0) in ltp-pan:
> 
> # umask
> 0077
> 
> # /opt/ltp/runltp -p -d results -l RUNTEST.log -o RUNTEST.run.log -s access01 -f syscalls > /dev/null
> 
> # cat /opt/ltp/results/RUNTEST.log
> Test Start Time: Fri Sep 22 14:24:28 2017
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> access01                       PASS       0    
> 
> I'm aware that running tests outside of ltp-pan is sometimes useful,
> so maybe we could add this to a library rather than in each test
> separately? What do you think Cyril?
Yes, I shouldn't run it without runltp script.

Thanks,
Bixuan Cui
> 
> Regards,
> Jan
> 
> 


