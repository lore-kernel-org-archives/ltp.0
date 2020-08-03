From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Aug 2020 08:12:00 -0400 (EDT)
Subject: [LTP] [PATCH v3] Add mincore() test for pages cached by another
 process
In-Reply-To: <20200803071312.4140-1-shwetha@zilogic.com>
References: <20200803071312.4140-1-shwetha@zilogic.com>
Message-ID: <1756062468.5779238.1596456720574.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> It tests the result of mincore when memory is mapped and cached by
> another process. A file is mapped in both parent and child
> process.Then the mapped memory is accessed in the child process. The
> results of mincore are tested in the parent process.
> 
> References:#460
> 
> Signed-off-by: Shwetha Subramanian. <shwetha@zilogic.com>
> Reviewed-by:Vijay Kumar B. <vijaykumar@zilogic.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

