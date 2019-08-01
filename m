From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 1 Aug 2019 06:39:42 -0400 (EDT)
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190801092616.30553-2-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
Message-ID: <1879623564.3992300.1564655982672.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> This commit adds a support for guarder buffers. Guarded buffer is a
> buffer allocated so that there is PROT_NONE page immediatelly after the
> end of the buffer i.e. any access after the buffer generates
> SEGFAULT/EFAULT etc.
> 
> The library is hooked into the tst_test structure so that all you need
> is to fill up an NULL terminated array of buffer pointers and sizes to
> get the respective buffers allocated. The library supports allocating
> memory in test runtime as well as well as allocating more complex
> buffers, which currently are iovec vectors.

Runtime alloc in loop could be an issue, do we need also runtime free?
