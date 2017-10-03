From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 3 Oct 2017 02:42:57 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/access01: Set umask value before run case
In-Reply-To: <20170925123142.GA25748@rei>
References: <1505826277-33027-1-git-send-email-cuibixuan@huawei.com>
 <875562.19773227.1506083326749.JavaMail.zimbra@redhat.com>
 <20170925123142.GA25748@rei>
Message-ID: <600752688.25562817.1507012977823.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > We do umask(0) in ltp-pan:
> > 
> > # umask
> > 0077
> > 
> > # /opt/ltp/runltp -p -d results -l RUNTEST.log -o RUNTEST.run.log -s
> > access01 -f syscalls > /dev/null
> > 
> > # cat /opt/ltp/results/RUNTEST.log
> > Test Start Time: Fri Sep 22 14:24:28 2017
> > -----------------------------------------
> > Testcase                       Result     Exit Value
> > --------                       ------     ----------
> > access01                       PASS       0
> > 
> > I'm aware that running tests outside of ltp-pan is sometimes useful,
> > so maybe we could add this to a library rather than in each test
> > separately? What do you think Cyril?
> 
> Running tests outside ltp-pan should indeed possible but I'm not sure
> that we want to change the umask in the test library. Most of the
> testcases will run with the more restrictive umask just fine and I would
> rather test the system in the default configuration. So changing it in
> the test setup in this case sounds reasonable to me.

OK, Will you push the patch?

Regards,
Jan
