From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Apr 2020 07:18:49 -0400 (EDT)
Subject: [LTP] [PATCH 1/2] add_key05: Avoid race with key garbage
 collection
In-Reply-To: <87v9maz1fj.fsf@our.domain.is.not.set>
References: <20200408090635.4686-1-rpalethorpe@suse.com>
 <d950a46d-b65a-ac33-e71b-f93a2dce7620@cn.fujitsu.com>
 <1200091233.7615565.1586341144193.JavaMail.zimbra@redhat.com>
 <87v9maz1fj.fsf@our.domain.is.not.set>
Message-ID: <1212083323.7622450.1586344729154.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hello,
> 
> Jan Stancek <jstancek@redhat.com> writes:
> 
> > ----- Original Message -----
> >> Hi Richard
> >>
> >> > The key subsystem independently tracks user info against UID. If a user
> >> > is
> >> > deleted and the UID reused for a new user then the key subsystem will
> >> > mistake
> >> > the new user for the old one.
> >
> > Thanks for raising this problem Richard. This matches CKI failure
> > we seen recently. (CC Li and Rachel)
> >
> >> Does any documentation or kernel comment mentioned this? I didn't notice
> >> this before.
> >> >
> >> > The keys/keyrings may not be accessible to the new user, but if they are
> >> > not
> >> > yet garbage collected (which happens asynchronously) then the new user
> >> > may
> >> > be
> >> > exceeding its quota limits.
> >> >
> >> > This results in a race condition where this test can fail because the
> >> > old
> >> > thread keyring is taking up the full quota. We should be able to avoid
> >> > this
> >> > by
> >> > creating two users in parallel instead of sequentially so that they have
> >> > different UIDs.
> >> I guess you may want to creat two user, so next, the key subsystem
> >> think the new user is different from  the last deleting user. It can
> >> avoid race.
> >>
> >> But you patch overrides ltpuser, in actually, we still use
> >> ltp_add_key05_1 in SAFE_SETUID.
> >>
> >> Also, this patch doesn't handle delete user when we using -i parameters.
> >
> > -i might be problem, but other than that I think it works, at least for
> > default run.
> >
> > Though I'm wondering, shouldn't the test delete keys it creates,
> > rather than relying on garbage collection?
> 
> I'm assuming the keys are 'deleted' when the thread keyring is destroyed
> when the child process exits. However they are not freed until later by
> garbage collection (maybe I am confusing deferred freeing with 'garbage
> collection'?).

Do you know how large is the race window?

Default /proc/sys/kernel/keys/gc_delay is 300, so if it's tied to this
garbage collect, I'd expect it to fail almost all the time.

> 
> We could explicitly delete/revoke the individual keys, but AFAICT there
> would still be a race because freeing is still asynchronous. Ofcourse
> there might be a reliable way to force freeing?

gc_delay is only one I recall.

If it's tied to process being around, I can try similar approach from 
e747d0456adc ("syscalls/tgkill03: wait for defunct tid to get detached")
where we wait for /proc/<pid>/task/<tid> to disappear.

