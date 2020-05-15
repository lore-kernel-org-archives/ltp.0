From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 11:06:16 +0200
Subject: [LTP] [PATCH v3 1/4] INSTALL: Update requirements,
 modernise text
In-Reply-To: <20200515090238.GA29151@dell5510>
References: <20200515070022.16407-1-pvorel@suse.cz>
 <1321342340.12558723.1589531383298.JavaMail.zimbra@redhat.com>
 <20200515090238.GA29151@dell5510>
Message-ID: <20200515090616.GA29676@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > Do we want to list also optional packages here?
> > libaio-devel libcap-devel numactl-devel openssl-devel and others?
> I was thinking to ask users to have look into travis/*.sh (if it's packaged),
Yes, travis files are packaged in tarball.

> as I was trying to avoid maintaining the dependencies on 2 places,
> but I can put it there.
No strong preference, I can add it and add note that other distros are
documented in travis/*.sh

Kind regards,
Petr
