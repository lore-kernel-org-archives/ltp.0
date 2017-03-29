From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 29 Mar 2017 16:56:03 +0200
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170329144800.3258e1a5@linux-v3j5>
References: <20170328100114.29730-1-chrubis@suse.cz>
 <20170329144800.3258e1a5@linux-v3j5>
Message-ID: <20170329165603.243f9495@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 29 Mar 2017 14:48:00 +0200
"Richard Palethorpe" <Richard.Palethorpe@suse.com> wrote:
> 
> Also it turns out that I am using some C syntax which is not accepted by GCC
> 4.3.4. This is annoying considering the tests compile fine with -std=C99 on
> GCC 6.
> 

Spoke too soon, it is just missing struct definitions.

