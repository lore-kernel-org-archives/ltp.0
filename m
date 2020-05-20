From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 May 2020 07:48:16 +0200
Subject: [LTP] [PATCH 1/1] C API: Turn .test_variants into array of
 description
In-Reply-To: <20200520044056.z67p66mubpok23gi@vireshk-i7>
References: <20200519120725.25750-1-pvorel@suse.cz>
 <20200519140704.GE16008@yuki.lan>
 <20200520044056.z67p66mubpok23gi@vireshk-i7>
Message-ID: <20200520054816.GA7251@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I do not think that having more ifdefs and splitting the test variant
> > structure helps to make things simple in the case of timer testcases.

> > What exact problem are you trying to solve?

> This is exactly what I thought about this when I saw the patch, and then also
> the problem of syncing two different arrays with their names (specially in my
> tests).
Agree, that wasn't optimal.

Kind regards,
Petr
