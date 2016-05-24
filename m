From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 May 2016 12:15:28 +0200
Subject: [LTP] [PATCH] memcg/functional: check several times if the
 process is killed
In-Reply-To: <57442727.3000600@oracle.com>
References: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160523160257.GF25488@rei.lan>
 <1653845167.258778.1464080543100.JavaMail.zimbra@redhat.com>
 <20160524091819.GA10029@rei.lan> <57442727.3000600@oracle.com>
Message-ID: <20160524101528.GB10029@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We should better change this for something more robust. Given that the
> > memgc_progcess does while (!flag_exit) sleep(1); in the main loop we may
> > as well wait till the process gets into the sleep state.
> >
> 
> I don't understand why it's more robust. For example, a process can get 
> into the sleep state (interruptible sleep) due to a call to a syscall, no?

Generally yes, but in this case it's unlikely that opening /dev/zero or
calling sigaction() would block.

> So maybe keep this sleep() as is?

I'm Ok with that one as well. But we should rethink and fix it later.

-- 
Cyril Hrubis
chrubis@suse.cz
