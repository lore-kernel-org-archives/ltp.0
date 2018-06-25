From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jun 2018 15:37:29 +0200
Subject: [LTP] [PATCH] abs01: Switch from <values.h> to <limits.h>
In-Reply-To: <20180622215710.126661-4-astrachan@google.com>
References: <20180622215710.126661-1-astrachan@google.com>
 <20180622215710.126661-4-astrachan@google.com>
Message-ID: <20180625133729.i4migeuiekz5ufgw@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alistair,

> The <values.h> is an obsolete glibc interface that wraps <limits.h> and
> <float.h>. The abs01 test only uses it for MININT, which can be
> switched over to <limits.h> and INT_MIN, for increased portability.

> Signed-off-by: Alistair Strachan <astrachan@google.com>

Pushed, thanks!


Kind regards,
Petr
