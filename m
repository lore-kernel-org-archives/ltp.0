From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 4 May 2017 13:27:47 +0200
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
In-Reply-To: <20170503160751.1634-1-pvorel@suse.cz>
References: <20170503160751.1634-1-pvorel@suse.cz>
Message-ID: <20170504132747.3d799242@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Wed,  3 May 2017 18:07:48 +0200
"Petr Vorel" <pvorel@suse.cz> wrote:

> BTW: I probably have source lines > 80 chars. My Vim doesn't highlight
> anything, but checkpatch.pl complain. I might have wrong vim configuration.

Are you using checkpatch.pl from kernel 4.11? It was recently changed to
follow the actual style guidelines which say lines over 80 chars are
preferable to strings being split over multiple lines. Maybe Vim is aware of
that?

Thank you,
Richard.
