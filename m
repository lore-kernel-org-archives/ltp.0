From: James Morris <james.l.morris@oracle.com>
Date: Wed, 10 Jan 2018 11:56:36 +1100 (AEDT)
Subject: [LTP] [PATCH v2 2/2] syscalls/request_key04: new test for
 request_key() permission check bug
In-Reply-To: <20180109220846.211823-2-ebiggers3@gmail.com>
References: <20180109220846.211823-1-ebiggers3@gmail.com>
 <20180109220846.211823-2-ebiggers3@gmail.com>
Message-ID: <alpine.LFD.2.20.1801101156230.25885@localhost>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 9 Jan 2018, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Add a test for a bug that allowed the request_key() system call to be
> used to add a key to a keyring using only Search permission.  This bug
> was assigned CVE-2017-17807.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

