From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 10:00:56 +0200
Subject: [LTP] [PATCH 4/6] lib: extend PATH as part of test setup
In-Reply-To: <1402903291.28351700.1507707959540.JavaMail.zimbra@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
 <fe40d9a0263afff913c646a6bc1fad88e0ce9747.1507647255.git.jstancek@redhat.com>
 <20171010151852.GA12028@rei>
 <1402903291.28351700.1507707959540.JavaMail.zimbra@redhat.com>
Message-ID: <20171011080056.GA29573@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > BTW, we should also drop the note about setting $PATH from the
> > documentation once this is merged.
> 
> Or tweak it to say, it's no longer necessary for newlib tests.

Ah, right we still do have oldlib tests.

-- 
Cyril Hrubis
chrubis@suse.cz
