#![no_std]
use core::ffi::*;


#[no_mangle]
pub extern "C" fn eventHandler(api: *const c_void, event: c_void, arg: u32) -> c_int { 0 }


#[panic_handler]
fn panic(#[allow(unused)] panic_info: &core::panic::PanicInfo) -> ! { loop {} }


use core::alloc::Layout;
use core::alloc::GlobalAlloc;
pub struct PlaydateAllocator;

#[global_allocator]
pub static GLOBAL: PlaydateAllocator = PlaydateAllocator;


unsafe impl GlobalAlloc for PlaydateAllocator {
	#[inline]
	unsafe fn alloc(&self, layout: Layout) -> *mut u8 { 0 as *mut u8 }
	#[inline]
	unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {}
	#[inline]
	unsafe fn realloc(&self, ptr: *mut u8, _layout: Layout, new_size: usize) -> *mut u8 { 0 as *mut u8 }
}


#[cfg(target_os = "macos")]
#[link(name = "System")]
extern "C" {}
