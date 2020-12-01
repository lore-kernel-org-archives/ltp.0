From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 1 Dec 2020 15:01:28 +0300
Subject: [LTP] [PATCH v2] netstress: explicitly set a thread stack size
In-Reply-To: <OF2BEB2003.14B7181E-ONC125862D.003F33FC-C125862D.003FF6BA@avm.de>
References: <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
 <OF2BEB2003.14B7181E-ONC125862D.003F33FC-C125862D.003FF6BA@avm.de>
Message-ID: <28ab3390-a16b-6183-62c8-50d782da2ad6@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27.11.2020 14:38, Johannes Nixdorf via ltp wrote:
> Musl libc uses a relatively small thread stack size (128k [1]). This
> gets used up on 2 local buffers sized max_msg_len (64k by default),
> which causes a segfault due to a stack overflow in the error reporting
> path.
> 
> Set the stack size to 256k instead, which is enough for both buffers
> with an additional allowance for the remaining stack usage by netstress
> and called libc or ltp helper functions.
> 
> [1]: https://urldefense.com/v3/__https://wiki.musl-libc.org/functional-differences-from-glibc.html*Thread_stack_size__;Iw!!GqivPVa7Brio!Nat9ZPBR2P2QxOM2IsBWR2WdfOQ1ZNM4IJzjNy5a_bTsHUko9bULz88kJAVK8yQ7Kk8-$ 
> 
> Signed-off-by: Johannes Nixdorf <j.nixdorf@avm.de>
> 
> ---
> 
> v2:
>   - Use a static limit of 256k.
>   - Document the requested stack size in the error message.
>   - Coding style fixup.
> 

Added extra parenthesis to silence possible compiler warnings
and applied, thanks Johannes!
