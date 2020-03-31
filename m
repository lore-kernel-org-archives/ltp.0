From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Mar 2020 09:39:12 +0200
Subject: [LTP] [PATCH v2 2/2] Fix calculations and defined constants
In-Reply-To: <20200330101222.25371-3-jpupava@suse.com>
References: <20200330101222.25371-1-jpupava@suse.com>
 <20200330101222.25371-3-jpupava@suse.com>
Message-ID: <20200331073912.GA22318@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jozef, Martin,

I like this version and fixes, it speeds up nearly to the original version,
even on ppc64le, thus merged (with slightly adjusted commit message).

f_bavail change could have been separated, but merged squashed.

Thanks for working on this!

Kind regards,
Petr
