From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 17:33:08 +0200
Subject: [LTP] [PATCH 1/4] tst_atomic: make tst_atomic_inc take a signed
 integer
In-Reply-To: <1325842962.871291.1460557922959.JavaMail.zimbra@redhat.com>
References: <82bcc056edc64dee3a13275a2b4bdbec958f60eb.1460552890.git.jstancek@redhat.com>
 <20160413140702.GC11529@rei.lan>
 <1325842962.871291.1460557922959.JavaMail.zimbra@redhat.com>
Message-ID: <20160413153307.GE11529@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > This is a preparation for upcoming patches, which add atomic_add_return(),
> > > that takes signed integer.
> > 
> > What is the problem with unsigned integer?
> 
> All atomic code in kernel is int based. I wanted to match that as closely
> as possible in our code.

I on x86 that should not matter as addition for numbers in two's
complement is just the same for both signed and unsigned numbers and the
instruction just sets both carry and overflow flags and
programmer/compiler just uses one of them depending on if the number is
supposed to be signed or unsigned.

But I'm not expert on powerpc assembly nor s390 assembly and I certainly
do not want to become one :). So let's follow what kernel does here.

-- 
Cyril Hrubis
chrubis@suse.cz
