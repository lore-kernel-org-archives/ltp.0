From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 14:22:19 +0200
Subject: [LTP] [PATCH 2/2 v2] security/dirtyc0w: synchronize parent and
 child
In-Reply-To: <1756862615.28187529.1507637839493.JavaMail.zimbra@redhat.com>
References: <94518262a76edca533440acb73611eb93184dc90.1507290372.git.jstancek@redhat.com>
 <0d87a0f1b598e710e21ebbabf316c39610e5d47f.1507290372.git.jstancek@redhat.com>
 <20171009144307.GC25633@rei.lan>
 <1756862615.28187529.1507637839493.JavaMail.zimbra@redhat.com>
Message-ID: <20171010122219.GC4970@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I ran into a problem with older distros - execvpe() does not
> exist there. How about we stay with execlp() and export
> LTP_IPC_PATH by default, so that child inherits it?

I guess that we can do setenv() in the test library once we initialize
the IPC.

-- 
Cyril Hrubis
chrubis@suse.cz
