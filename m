From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Mar 2019 09:31:42 +0100
Subject: [LTP] [PATCH v2] syscall: Add userfaultfd testcase
In-Reply-To: <824216999.8470703.1552563760595.JavaMail.zimbra@redhat.com>
References: <20190314085717.10207-1-camann@suse.com>
 <824216999.8470703.1552563760595.JavaMail.zimbra@redhat.com>
Message-ID: <20190315083142.GB25064@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > +
> > +	pollfd.fd = uffd;
> > +	pollfd.events = POLLIN;
> > +	nready = poll(&pollfd, 1, -1);

> SAFE_POLL

We don't have SAFE_POLL() (yet).


Kind regards,
Petr
