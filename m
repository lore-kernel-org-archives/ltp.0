From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Sep 2020 11:47:45 +0200
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Add smoketest
In-Reply-To: <CY4PR13MB1175D646B9A4D84ABC6C9276FD3A0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <20200921114026.11184-1-chrubis@suse.cz>
 <CY4PR13MB1175D646B9A4D84ABC6C9276FD3A0@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200922094745.GB14557@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > +route4-change-dst route-change-dist.sh

> this should be:
> route4-change-dst route-change-dst.sh
Good catch, thanks! Obviously typo.

Kind regards,
Petr

> $ find . -name "route-change-d*"
> ./testcases/network/stress/route/route-change-dst.sh
