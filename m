From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 09:49:59 -0500
Subject: [LTP] Hidden TPM questions in the LTP IMA posts
Message-ID: <1516978199.29187.43.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Jarkko,

There are a few TPM questions for the fixing the IMA Linux Test
Program (LTP) tests:

- The maximum size of the TPM 1.2 event record is unspecified.  What
is the expected maximum size?
- Is there a way of knowing the location of the TPM 1.2 PCRs without
grepping for them?

Additional question:
- Are the TPM 2.0 PCRs and event log exported by the kernel?  If not,
how are they accessed?

thanks,

Mimi

