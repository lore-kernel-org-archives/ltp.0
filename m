From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jun 2021 11:14:45 +0200
Subject: [LTP] [RFC PATCH v2 0/2] Libclang based analyzer
In-Reply-To: <85bddc61-f6dc-de7c-3a62-daeefcd0a058@jv-coder.de>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <85bddc61-f6dc-de7c-3a62-daeefcd0a058@jv-coder.de>
Message-ID: <YL3jhejzH6hTYuPZ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> So in conclusion, I do not think we can assume libclang to be available 
> for all developers and installing it is probably more work, at least 
> when newer functions from libclang are used, than installing coccinelle.
> And very important for final setup: It must be possible to successfully 
> compile ltp, without libclang/coccinelle available. There is no reason 
> to force this libraries/tools for pure "users" of ltp.

Indeed this is supposed to be tooling for developers and strictly
optional. If this breaks builds without libclang it has to be fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
