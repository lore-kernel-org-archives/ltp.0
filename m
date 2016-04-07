From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Apr 2016 10:26:04 +0200
Subject: [LTP] [PATCH] syscalls/fcntl: add new test for open file
 description locks
In-Reply-To: <5706104A.70307@oracle.com>
References: <1458033988-15881-1-git-send-email-alexey.kodanev@oracle.com>
 <20160406160733.GC10599@rei.suse.cz> <5706104A.70307@oracle.com>
Message-ID: <20160407082603.GA15786@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +		++res[(int)buf[0]];
> >                           ^
> > 			Do we really need to cast it to int here?
> 
> 
> Otherwise gcc would complain  "warning: array subscript has type ?char?"

Hmm, perhaps the compiler tries to warn you that char may be signed or
unsigned depending on a architecture and compiler implementation. Does
the warning goes away if you declare the buf as a unsigned char?

-- 
Cyril Hrubis
chrubis@suse.cz
