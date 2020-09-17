From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Sep 2020 07:53:46 +0200
Subject: [LTP] ltp-selftest-quick runtest file (was RE:  LTP release)
In-Reply-To: <CY4PR13MB11750B438B7F73126B88240BFD210@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB11752979CBBBBCAD98EC86E0FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200916070440.GA1433@dell5510>
 <CY4PR13MB11750B438B7F73126B88240BFD210@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200917055346.GA17236@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Tim,

...
> > > Is there a networking one with less requirements, that is basically guaranteed to work?
> > Good catch. Although TCONF is also a test for shell API :), let's use plan shell
> > implementation:
> > route6-change-dst route-change-dst.sh -6

> This one worked on some of my boards and not others, due to ipv6 not being
> configured on some of them.

> How about this instead:
> route4-change-dst route-change-dist.sh
ack.
(I consider TCONF as not failure, but let's use IPv4).

Petr
