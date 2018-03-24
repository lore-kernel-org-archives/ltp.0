From: Ram Pai <linuxram@us.ibm.com>
Date: Fri, 23 Mar 2018 17:44:40 -0700
Subject: [LTP] [bug?] Access was denied by memory protection keys in
 execute-only address
In-Reply-To: <CAEemH2c4p7FqYs9L9X0SyjUvg5Z3pfwsokurJmzq+=y1h2OwbA@mail.gmail.com>
References: <CAEemH2f0LDqyR5AmUYv17OuBc5-UycckDPWgk46XU_ghQo4diw@mail.gmail.com>
 <871sguep4v.fsf@concordia.ellerman.id.au>
 <20180308164545.GM1060@ram.oc3035372033.ibm.com>
 <CAEemH2czWDjvJLpL6ynV1+VxCFh_-A-d72tJhA5zwgrAES2nWA@mail.gmail.com>
 <20180320215828.GA5825@ram.oc3035372033.ibm.com>
 <CAEemH2eewab4nsn6daMRAtn9tDrHoZb_PnbH8xA17ypFCTg6iA@mail.gmail.com>
 <20180322070900.GA5605@ram.oc3035372033.ibm.com>
 <CAEemH2c4p7FqYs9L9X0SyjUvg5Z3pfwsokurJmzq+=y1h2OwbA@mail.gmail.com>
Message-ID: <20180324004440.GA5887@ram.oc3035372033.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, Mar 23, 2018 at 05:27:06PM +0800, Li Wang wrote:
>    On Thu, Mar 22, 2018 at 3:09 PM, Ram Pai <[1]linuxram@us.ibm.com> wrote:
> 
>      On Wed, Mar 21, 2018 at 02:53:00PM +0800, Li Wang wrote:
>      >    On Wed, Mar 21, 2018 at 5:58 AM, Ram Pai
>      <[1][2]linuxram@us.ibm.com> wrote:
>      >    that why not disable the pkey_execute_disable_supported on p8
.snip..

>      machine?
> 
>      It turns out to be a testcase bug.  On Big endian powerpc ABI, function
>      ptrs are basically pointers to function descriptors.  The testcase
>      copies functions which results in function descriptors getting copied.
>      You have to apply the following patch to your test case for it to
>      operate as intended.  Thanks to Michael Ellermen for helping me out.
>      Otherwise I would be scratching my head for ever.
> 
>    ​Thanks for the explanation, I learned something new about this. :)
> 
>    And the worth to say, seems the patch only works on powerpc arch,
>    others(x86_64, etc)
>    that does not works well, so a simple workaround is to isolate the code
>    changes
>    to powerpc system?

yes. this code has to be made applicable to powerpc Big-endian code
only.  The powerpc little-endian code remains unchanged.

RP

