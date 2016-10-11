From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Oct 2016 18:15:57 +0200
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
In-Reply-To: <57FD098C.4060102@oracle.com>
References: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160829125050.GD30021@rei.lan> <57C43307.8000709@oracle.com>
 <8140813.24444.1472477694219.JavaMail.zimbra@redhat.com>
 <57C43FEF.50402@oracle.com> <57C440C0.5050307@oracle.com>
 <2063556369.71871.1472485781200.JavaMail.zimbra@redhat.com>
 <57FCD515.20202@oracle.com> <20161011133824.GA17083@rei.suse.cz>
 <57FD098C.4060102@oracle.com>
Message-ID: <20161011161557.GD17083@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Isn't the original patch just workaround? Since we write to the nfs
> > TMPDIR as well, just differently, there is always possibility that we
> > only made the problem less probable and that it will fail in one of
> > thousand runs. Have you tried to run the test in a loop for some time?
> 
> Yes, the original patch is a workaround.
> 
> On my system I met 1 failure of 20000 runs (~1 hour).
> 
> Maybe we need to follow your proposal and test only the first two fields
> from lsmod.

We may also try to store the output from lsmod and /proc/modules to
shell variables. Something as:

a=$(awk '{print $1, $2, $3}' /proc/modules |sort)
b=$(lsmod | awk '!/Module/{print $1, $2, $3}' |sort)

Then compare $a and $b.

-- 
Cyril Hrubis
chrubis@suse.cz
