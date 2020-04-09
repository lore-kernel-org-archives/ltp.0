From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Apr 2020 07:32:06 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] add_key05: Avoid race with key garbage
 collection
In-Reply-To: <87v9mahzgf.fsf@our.domain.is.not.set>
References: <20200408090635.4686-1-rpalethorpe@suse.com>
 <d950a46d-b65a-ac33-e71b-f93a2dce7620@cn.fujitsu.com>
 <1200091233.7615565.1586341144193.JavaMail.zimbra@redhat.com>
 <87v9maz1fj.fsf@our.domain.is.not.set>
 <1212083323.7622450.1586344729154.JavaMail.zimbra@redhat.com>
 <87k12qyzmq.fsf@our.domain.is.not.set> <87v9mahzgf.fsf@our.domain.is.not.set>
Message-ID: <2007623874.7795838.1586431926226.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hello,
> 
> Richard Palethorpe <rpalethorpe@suse.de> writes:
> 
> >>> I'm assuming the keys are 'deleted' when the thread keyring is destroyed
> >>> when the child process exits. However they are not freed until later by
> >>> garbage collection (maybe I am confusing deferred freeing with 'garbage
> >>> collection'?).
> >>
> >> Do you know how large is the race window?
> >>
> >> Default /proc/sys/kernel/keys/gc_delay is 300, so if it's tied to this
> >> garbage collect, I'd expect it to fail almost all the time.
> >
> > It doesn't appear to be tied to that.
> >
> >>
> >>> 
> >>> We could explicitly delete/revoke the individual keys, but AFAICT there
> >>> would still be a race because freeing is still asynchronous. Ofcourse
> >>> there might be a reliable way to force freeing?
> >>
> >> gc_delay is only one I recall.
> >>
> >> If it's tied to process being around, I can try similar approach from
> >> e747d0456adc ("syscalls/tgkill03: wait for defunct tid to get detached")
> >> where we wait for /proc/<pid>/task/<tid> to disappear.
> >
> >
> > This might work as the work is scheduled to be done in process context,
> > so the task may remain until the keys have been freed.
> 
> This doesn't seem to work.

We should probably go with your approach for now: create 2 users ahead,
so at least default case works.

I have difficulty reproducing failure on demand.

