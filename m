From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 May 2020 05:10:39 -0400 (EDT)
Subject: [LTP] [PATCH v3 1/4] INSTALL: Update requirements,
 modernise text
In-Reply-To: <20200515090616.GA29676@dell5510>
References: <20200515070022.16407-1-pvorel@suse.cz>
 <1321342340.12558723.1589531383298.JavaMail.zimbra@redhat.com>
 <20200515090238.GA29151@dell5510> <20200515090616.GA29676@dell5510>
Message-ID: <962317877.12564854.1589533839512.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > > Do we want to list also optional packages here?
> > > libaio-devel libcap-devel numactl-devel openssl-devel and others?
> > I was thinking to ask users to have look into travis/*.sh (if it's
> > packaged),
> Yes, travis files are packaged in tarball.
> 
> > as I was trying to avoid maintaining the dependencies on 2 places,
> > but I can put it there.

Pointer to different file is fine. Just so it's clear that listed requirements
are bare minimum, and some tests need extra libraries to work.

