From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 24 May 2016 06:32:46 -0400 (EDT)
Subject: [LTP] [PATCH] memcg/functional: check several times if the
 process is killed
In-Reply-To: <20160524101528.GB10029@rei.lan>
References: <1463669724-7193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160523160257.GF25488@rei.lan>
 <1653845167.258778.1464080543100.JavaMail.zimbra@redhat.com>
 <20160524091819.GA10029@rei.lan> <57442727.3000600@oracle.com>
 <20160524101528.GB10029@rei.lan>
Message-ID: <812583643.272236.1464085966204.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> Cc: "Jan Stancek" <jstancek@redhat.com>, "vasily isaenko" <vasily.isaenko@oracle.com>, ltp@lists.linux.it
> Sent: Tuesday, 24 May, 2016 12:15:28 PM
> Subject: Re: [LTP] [PATCH] memcg/functional: check several times if the process is killed
> 
> Hi!
> > > We should better change this for something more robust. Given that the
> > > memgc_progcess does while (!flag_exit) sleep(1); in the main loop we may
> > > as well wait till the process gets into the sleep state.
> > >
> > 
> > I don't understand why it's more robust. For example, a process can get
> > into the sleep state (interruptible sleep) due to a call to a syscall, no?
> 
> Generally yes, but in this case it's unlikely that opening /dev/zero or
> calling sigaction() would block.

There's also some ld setup going on before that. Opening/mapping/reading
various config and .so files.

> 
> > So maybe keep this sleep() as is?
> 
> I'm Ok with that one as well. But we should rethink and fix it later.

My immediate idea was to let memcg_process open "/tmp/memcg_process_ready"
and shell script would monitor /proc/$pid/fd/ until sees that or hits timeout.

Regards,
Jan
