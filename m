From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Wed, 15 Jul 2020 15:34:10 -0400
Subject: [LTP] [PATCH v4 1/2] IMA: Add a test to verify measurment of
 keys
In-Reply-To: <1594773355.12900.210.camel@linux.ibm.com>
References: <20200626021126.56760-1-t-josne@linux.microsoft.com>
 <20200626021126.56760-2-t-josne@linux.microsoft.com>
 <1594773355.12900.210.camel@linux.ibm.com>
Message-ID: <7d8ac937-00d6-3cc1-7d38-3417580512d9@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/14/20 8:35 PM, Mimi Zohar wrote:
> An additional test might be to verify that only the keys in the
> measurement list are actually on the specified keyring and nothing
> else.
That seems like a good idea. I may not have time to implement it however.
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
- Lachlan
