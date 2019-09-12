From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Thu, 12 Sep 2019 18:47:20 +0200
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set
 by user
In-Reply-To: <20190912152820.GB1064@dell5510>
References: <20190829181146.20261-1-pvorel@suse.cz>
 <CAEemH2dzn92GYwiw2tP101wNkYfM30rfL=cmPU+B1iH-8UWoDw@mail.gmail.com>
 <20190830085036.GA27453@dell5510>
 <9e518589-9c98-1513-2c19-bae0268b8a81@arm.com>
 <20190830104609.GA9330@dell5510>
 <CAEemH2ch1+asP7OKikqrM4Sea2f2xvVB4JPbUqDkm41cFJ+kdg@mail.gmail.com>
 <1568279073.3621.12.camel@suse.de>
 <CAEemH2cw+O5ZrZyQV5qy7wp6-h1SSinu3ENueRG7Gr--xJCRfA@mail.gmail.com>
 <e07d08e2-df58-2114-0278-8f1e50f2ac3a@arm.com>
 <20190912152820.GB1064@dell5510>
Message-ID: <1568306840.3621.32.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2019-09-12 at 17:28 +0200, Petr Vorel wrote:
> Hi,
> 
> LTP_TIMEOUT_MUL is only for user, LTP_TIMEOUT_MUL_MIN is only for
> library.
> It's similar to way which is used in virt_lib.sh
> (VIRT_PERF_THRESHOLD_MIN).

Agree that LTP_TIMEOUT_MUL is for the user and the initial timeout
value comes from library.
I only say, that a LTP_TIMEOUT_MUL_MIN isn't needed from my
perspective, if we allow to set a absolute timeout value like
TST_TIMEOUT (as we already do in c). Because it has the same effect,
setting a minimum timeout value which the user cannot reduce.


> See
> https://patchwork.ozlabs.org/patch/1155460/
> 
> I'll probably sent this patch today although so you can base the work
> on it.
> Is that ok?
sure it is.

