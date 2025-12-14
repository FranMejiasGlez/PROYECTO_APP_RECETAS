const User = require("../models/user"); 
const createUserService = async (userData) => {
  const newUser = new User(userData);
  return await newUser.save();
};

const getAllUsersService = async () => {
  return await User.find();
};

const getUserByIdService = async (id) => {
  return await User.findOne({ id: id });
};

const updateUserService = async (id, updateData) => {
  return await User.findOneAndUpdate(
    { id: id },
    updateData,
    { new: true }
  );
};

const deleteUserService = async (id) => {
  return await User.findOneAndDelete({ id: id });
};

module.exports = {
  createUserService,
  getAllUsersService,
  getUserByIdService,
  updateUserService,
  deleteUserService
};