From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Nov 2019 01:40:56 -0500 (EST)
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <CAEemH2dZCm5MVyhzWiFKVK-jt+UUw65u5CRFk-moUVUgpDHHWg@mail.gmail.com>
References: <20191119094156.20348-1-liwang@redhat.com>
 <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
 <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
 <c9d278e6-5700-6c16-019b-1770a6ede0ff@suse.cz>
 <CAEemH2dZCm5MVyhzWiFKVK-jt+UUw65u5CRFk-moUVUgpDHHWg@mail.gmail.com>
Message-ID: <1055215037.13116966.1574232056907.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> > You don't need to reduce the write size in the first place. Kernel will
> > happily do short writes for you if the file system somehow finds some
> >
> 
> You're probably right, but here I just want to enhance the tst_fill_fs
> routine, it obviously couldn't  be guaranteed way to perfectly fill a
> filesystem, this action from userspace is what I can think of.
> 
> 
> > free blocks. The more important question is how to trigger garbage
> > collection of internal file system book-keeping data.
> >
> 
> Okay. I'm not good at FS issues. Or, do you have a better idea for that?

FS devs mentioned couple ideas. Repeated writes (this thread), fsync, mount+umount.
But all suggestions were from "better" category, don't think we have 100% reliable one.

