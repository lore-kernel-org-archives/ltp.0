From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 11:02:38 +0200
Subject: [LTP] [PATCH v3 1/4] INSTALL: Update requirements,
 modernise text
In-Reply-To: <1321342340.12558723.1589531383298.JavaMail.zimbra@redhat.com>
References: <20200515070022.16407-1-pvorel@suse.cz>
 <1321342340.12558723.1589531383298.JavaMail.zimbra@redhat.com>
Message-ID: <20200515090238.GA29151@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ----- Original Message -----
> > +# yum install gcc git make pkgconf autoconf automake bison flex m4
> > kernel-headers glibc-headers

> Do we want to list also optional packages here?
> libaio-devel libcap-devel numactl-devel openssl-devel and others?
I was thinking to ask users to have look into travis/*.sh (if it's packaged),
as I was trying to avoid maintaining the dependencies on 2 places,
but I can put it there.

Kind regards,
Petr
