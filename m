From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 24 Aug 2020 12:06:45 +0100
Subject: [LTP] BUG: Bad page state in process true  pfn:a8fed on arm
In-Reply-To: <CA+G9fYt=oYWHEG6VNkfEh8+UxbReS6_+9hnz+1bOYZHj5j1F_Q@mail.gmail.com>
References: <CA+G9fYt=oYWHEG6VNkfEh8+UxbReS6_+9hnz+1bOYZHj5j1F_Q@mail.gmail.com>
Message-ID: <20200824110645.GC17456@casper.infradead.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 24, 2020 at 03:14:55PM +0530, Naresh Kamboju wrote:
> [   67.545247] BUG: Bad page state in process true  pfn:a8fed
> [   67.550767] page:9640c0ab refcount:0 mapcount:-1024

Somebody freed a page table without calling __ClearPageTable() on it.

