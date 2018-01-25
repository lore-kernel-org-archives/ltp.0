From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 15:20:58 +0100
Subject: [LTP] [PATCH v2] Add library support for
	/proc/sys/kernel/tainted
In-Reply-To: <20180125132814.GA19878@rei.lan>
References: <20180125121641.26795-1-mmoese@suse.de>
 <20180125132814.GA19878@rei.lan>
Message-ID: <20180125142058.ubfl2357cyry3erj@linux.suse>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

On Thu, Jan 25, 2018 at 02:28:15PM +0100, Cyril Hrubis wrote:

> I would have probably put these into an array of structures indexed by
> the position of the flag bit, but it's fine as it is as well.

I considered this, but as I only have the bits, I would have to 
introduce a second parameter, to get it in a consecutive manner. 

I was thinking this would be shorter for now - if we don't like it I 
can change this anyway, later.

Thanks for the review

Michael
- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
