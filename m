From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Mar 2019 04:38:01 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscall: Add userfaultfd testcase
In-Reply-To: <20190315083142.GB25064@dell5510>
References: <20190314085717.10207-1-camann@suse.com>
 <824216999.8470703.1552563760595.JavaMail.zimbra@redhat.com>
 <20190315083142.GB25064@dell5510>
Message-ID: <724278354.9098410.1552639081478.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan,
> 
> > > +
> > > +	pollfd.fd = uffd;
> > > +	pollfd.events = POLLIN;
> > > +	nready = poll(&pollfd, 1, -1);
> 
> > SAFE_POLL
> 
> We don't have SAFE_POLL() (yet).

You're right, ignore this comment. 

> 
> 
> Kind regards,
> Petr
> 
