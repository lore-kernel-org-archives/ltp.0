From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 17:09:48 +0100
Subject: [LTP] [PATCH v4 2/2] pkey01: disable hugetlb test if failed to
 reserve hugepage
In-Reply-To: <20200208092014.24824-2-liwang@redhat.com>
References: <20200208092014.24824-1-liwang@redhat.com>
 <20200208092014.24824-2-liwang@redhat.com>
Message-ID: <20200217160948.GB6482@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> To handle the false positive:
>   pkey01.c:69: BROK: nr_hugepages = 0, but expect 1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
