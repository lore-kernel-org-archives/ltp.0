From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 10:10:28 +0100
Subject: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and
 pread() declarations
In-Reply-To: <365395850.1733202.1484212029508.JavaMail.zimbra@redhat.com>
References: <20170102154707.GA30109@rei.lan> <20170111144126.GA9518@rei.lan>
 <1178986959.1715131.1484209995886.JavaMail.zimbra@redhat.com>
 <20170112090232.GA16875@rei.lan>
 <365395850.1733202.1484212029508.JavaMail.zimbra@redhat.com>
Message-ID: <20170112091028.GB16875@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Not anymore, there was one user with zero offset which was converted to
> > plain old SAFE_WRITE() and these two safe macros were then removed from
> > oldlib safe macros in f4b028122.
> 
> Ah, I see. No objections to patch from my side.

Pushed with your ack.

-- 
Cyril Hrubis
chrubis@suse.cz
