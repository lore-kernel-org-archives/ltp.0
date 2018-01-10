From: James Morris <james.l.morris@oracle.com>
Date: Wed, 10 Jan 2018 11:56:10 +1100 (AEDT)
Subject: [LTP] [PATCH v2 1/2] lapi/keyctl.h: add key permission constants
In-Reply-To: <20180109220846.211823-1-ebiggers3@gmail.com>
References: <20180109220846.211823-1-ebiggers3@gmail.com>
Message-ID: <alpine.LFD.2.20.1801101155520.25885@localhost>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 9 Jan 2018, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Add the key permission constants to keyctl.h so that they don't have to
> be defined in each test that uses them.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>



Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>

