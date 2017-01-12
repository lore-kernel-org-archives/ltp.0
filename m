From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 10:02:32 +0100
Subject: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and
 pread() declarations
In-Reply-To: <1178986959.1715131.1484209995886.JavaMail.zimbra@redhat.com>
References: <20170102154707.GA30109@rei.lan> <20170111144126.GA9518@rei.lan>
 <1178986959.1715131.1484209995886.JavaMail.zimbra@redhat.com>
Message-ID: <20170112090232.GA16875@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I was thinking about this, and I think that we should rather go with a
> > safer approach, i.e. moving the safe_pread/safe_pwrite into a separate
> > header. Something as the following patch.
> 
> +1 for safer approach, I didn't know about glibc macros.
> Does this affect oldlib too?

Not anymore, there was one user with zero offset which was converted to
plain old SAFE_WRITE() and these two safe macros were then removed from
oldlib safe macros in f4b028122.

-- 
Cyril Hrubis
chrubis@suse.cz
