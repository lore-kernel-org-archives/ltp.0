From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 1 Apr 2021 09:23:50 +0200
Subject: [LTP] [PATCH] crypto_user02: Find a valid template
In-Reply-To: <YGIiE5/DnjXrcHzK@gmail.com>
References: <20210315130349.1155389-1-lkml@jv-coder.de>
 <YGIiE5/DnjXrcHzK@gmail.com>
Message-ID: <YGV1BjumOxzeYBaz@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> "template" means something like "hmac" by itself.  This probably should be
> called something like ALGORITHM_CANDIDATES, and similarly template => algorithm
> in a couple places below.
Also left template in commit message. Silly mistake, I'm sorry.

Kind regards,
Petr
