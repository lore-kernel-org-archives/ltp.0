From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Wed, 28 Jul 2021 17:00:55 +0300
Subject: [LTP] [PATCH v1] lib/tst_test.sh: skip test if ip returns
 "Error: Unknown device type"
In-Reply-To: <YQFWT/0MBcZsLNVV@pevik>
References: <20210722063422.18059-1-radoslav.kolev@suse.com>
 <YPkjE3KHHnhYklp/@pevik> <8b564e10-d87e-aaf0-03a4-1af347f02d4b@suse.com>
 <8cc8d5bc-b651-8e15-6389-69f36cf6bb49@bell-sw.com> <YP/ZxhYSZb/NusUs@pevik>
 <c94e1459-07d5-ceb0-f113-9d3f57343983@bell-sw.com> <YQFWT/0MBcZsLNVV@pevik>
Message-ID: <c78c6b1a-2793-de86-a263-5bcf58ab41da@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/28/21 4:06 PM, Petr Vorel wrote:
> Yep, that'd be safer. But your original proposal to check ip_vti ip6_vti
> is IMHO the best solution. Radoslav, would you send a new patch with it?

Agreed that the proposed by Alexey is a better approach. Yes, patch is 
coming.

