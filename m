From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 24 Nov 2016 16:41:05 +0300
Subject: [LTP] [PATCH 4/4] network/ipsec: add vti tunnel test & new
 options for enc algs
In-Reply-To: <1475762095-14612-4-git-send-email-alexey.kodanev@oracle.com>
References: <1475762095-14612-1-git-send-email-alexey.kodanev@oracle.com>
 <1475762095-14612-4-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <5836EDF1.1000407@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 10/06/2016 04:54 PM, Alexey Kodanev wrote:
> * Add vti with IPsec policies, send ICMP messages through the tunnel.
>    New test-cases include ah, esp protocols over vti and vti6 +
>    new authentication and encryption algorithms.
>
> * New options in ipsec_lib.sh:
>    'e' - Encryption algorithm,
>    'a' - Authentication algorithm,
>    'c' - Compression algorithm.
>
> * Dynamically generates algorithms random keys based on predefined key
>    length for each algorithm type.
> ...
> +	local sel='src 0.0.0.0/0 dst 0.0.0.0/0'
> +	if [ "$TST_IPV6" ]; then
> +		sel='src ::/0 dst ::/0'
> +	fi
> +

I've removed setting selected traffic explicitly here as it should be 
correctly set by default for IPv6
if we add '-6' option to ip command. Also corrected lines over 80 
characters and applied the patch-set.

Best regards,
Alexey

