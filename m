From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Feb 2020 16:50:12 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz>
 <20200205143107.GC30186@rei>
 <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz>
Message-ID: <20200205155012.GA4920@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Why can't we keep the code in the header? I do not condsider this to be
> > improving anything at all.
> 
> Because executable code doesn't belong in header files unless necessary.
> Header files are as much API documentation for developers as they are
> code for compilers. And header files full of executable code make
> terrible API documentation.

That's only true if we are building and external interface for a
library, here we are just avoiding copy&paste by the simpliest means
available.

-- 
Cyril Hrubis
chrubis@suse.cz
