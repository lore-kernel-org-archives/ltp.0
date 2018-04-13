From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 13 Apr 2018 09:40:44 -0400 (EDT)
Subject: [LTP] [RFC PATCH 6/6] syscalls/wait401: Rewrite to the new
 library
In-Reply-To: <20180409094440.GA31983@rei>
References: <20180405145015.7633-1-chrubis@suse.cz>
 <20180405145015.7633-7-chrubis@suse.cz>
 <1134024977.11699650.1523004862083.JavaMail.zimbra@redhat.com>
 <20180409094440.GA31983@rei>
Message-ID: <342181934.13231842.1523626844187.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 9 April, 2018 11:44:40 AM
> Subject: Re: [LTP] [RFC PATCH 6/6] syscalls/wait401: Rewrite to the new library
> 
> Hi!
> > This doesn't seem to test that wait4() waits. The child can
> > end before call to wait4().
> > 
> > What if added call to tst_process_state_wait() to child,
> > so it waits on parent to sleep? If parent sleeps, then
> > it's likely waiting on child.
> 
> That's a good idea, I've changed the test to do exactly that.
> 
> OK to commit with the changes you requested or should I resend the fixed
> patchset?

Sorry for delay, I overlooked this email. No need to resend, ACK.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
