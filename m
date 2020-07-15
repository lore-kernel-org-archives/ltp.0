From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 14 Jul 2020 20:35:55 -0400
Subject: [LTP] [PATCH v4 1/2] IMA: Add a test to verify measurment of
 keys
In-Reply-To: <20200626021126.56760-2-t-josne@linux.microsoft.com>
References: <20200626021126.56760-1-t-josne@linux.microsoft.com>
 <20200626021126.56760-2-t-josne@linux.microsoft.com>
Message-ID: <1594773355.12900.210.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2020-06-25 at 22:11 -0400, Lachlan Sneff wrote:
> Add a testcase that verifies that the IMA subsystem has correctly
> measured keys added to keyrings specified in the IMA policy file.
> 
> Additionally, add support for handling a new IMA template descriptor,
> namely ima-buf[1], in the IMA measurement tests.
> 
> [1]: https://www.kernel.org/doc/html/latest/security/IMA-templates.html#use
> 
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>

An additional test might be to verify that only the keys in the
measurement list are actually on the specified keyring and nothing
else.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

