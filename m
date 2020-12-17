From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 17 Dec 2020 11:56:51 -0500
Subject: [LTP] [PATCH v5 1/4] IMA: Move get_algorithm_digest(),
 set_digest_index() to ima_setup.sh
In-Reply-To: <20201214221946.6340-2-pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <20201214221946.6340-2-pvorel@suse.cz>
Message-ID: <aed2e8ee7b05772a8cc2988ae275282bec7ef504.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thank you!

On Mon, 2020-12-14 at 23:19 +0100, Petr Vorel wrote:
> To be reusable by more tests (preparation for next commit).
> 
> Call set_digest_index() inside get_algorithm_digest() if needed
> instead of expecting get_algorithm_digest() caller to call
> set_digest_index() before.

For the existing builtin templates, the algorithm/digest field is
consistent.  With support for per policy rule template formats, there
isn't necessarily a single template format for the entire list.

In the future "set_digest_index" might need to be renamed to
"get_digest_index" and the lookup done for each line.

> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

