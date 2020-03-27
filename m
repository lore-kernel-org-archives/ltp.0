From: Jozef Pupava <jpupava@suse.cz>
Date: Fri, 27 Mar 2020 11:15:46 +0100
Subject: [LTP] [PATCH 2/2] Avoid zero or negative int results in
 calculations
In-Reply-To: <20200327095715.GA16912@dell5510>
References: <20200324143839.3647c485@daedruan>
 <20200326084504.GB29830@dell5510> <20200326134603.GA5185@yuki.lan>
 <20200326203222.GA19445@dell5510> <20200327095715.GA16912@dell5510>
Message-ID: <20200327111546.07d8e28c@daedruan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I will try to decrease, ideally remove the slowdown.

Jozef

On Fri, 27 Mar 2020 10:57:15 +0100
Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
> 
> > Before:
> > real	0m0,013s  
> 
> > After (slowed by second commit, not by the rewrite):
> > real	0m0,402s  
> 
> Although the slowdown it's ~30 times, it's obviously fast enough,
> so I wouldn't consider it as a problem. I was just surprised by it.
> 
> My concern is about brief explanation where/how is zero or negative
> result appears. But maybe it's obvious and I just don't see it.
> 
> Kind regards,
> Petr

